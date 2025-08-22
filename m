Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F0ACA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 07:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8925140657;
	Fri, 22 Aug 2025 09:19:49 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 4304240651
 for <dev@dpdk.org>; Fri, 22 Aug 2025 09:19:48 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id C1355109F4
 for <dev@dpdk.org>; Fri, 22 Aug 2025 09:19:47 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id B4A47109F3; Fri, 22 Aug 2025 09:19:47 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id A379410B16;
 Fri, 22 Aug 2025 09:19:45 +0200 (CEST)
Message-ID: <5427c6f3-4446-4ee3-909e-5f2925d2b286@lysator.liu.se>
Date: Fri, 22 Aug 2025 09:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] hash: add support for common small key sizes
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250821203646.133506-4-stephen@networkplumber.org>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20250821203646.133506-4-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025-08-21 22:35, Stephen Hemminger wrote:
> Add new compare functions for common small key sizes.
> 
> Bugzilla ID: 1775
> Suggested-by: Morten Brørup <mb@smartsharesystems.com>
> Reported-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   lib/hash/rte_cuckoo_hash.c | 54 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> index 3212695d92..825889c320 100644
> --- a/lib/hash/rte_cuckoo_hash.c
> +++ b/lib/hash/rte_cuckoo_hash.c
> @@ -49,6 +49,11 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
>    */
>   enum cmp_jump_table_case {
>   	KEY_CUSTOM = 0,
> +	KEY_2_BYTES,
> +	KEY_4_BYTES,
> +	KEY_6_BYTES,
> +	KEY_8_BYTES,
> +	KEY_12_BYTES,
>   	KEY_16_BYTES,
>   	KEY_32_BYTES,
>   	KEY_48_BYTES,
> @@ -86,6 +91,50 @@ rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
>   }
>   #endif
>   
> +static inline int
> +rte_hash_k2_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
> +{
> +	const uint16_t *k1 = key1;
> +	const uint16_t *k2 = key2;
> +

What we do now is to require the keys are 16-bit aligned (which wasn't 
the case before).

You could

uint16_t k1;
memcpy(&k1, key1, sizeof(uint16_t));
instead.

Would generate the same code, but be safe from any future alignment issues.

Anyway, maybe it's safe to assume the keys are aligned, so this is not 
an issue.

> +	return k1[0] ^ k2[0];
> +}

Haven't you implemented "neq" rather than "eq" here? If the keys are 
equal, the result is 0. Should be != 0.

Would it be worth adding a comment like "use XOR to make this 
branch-free"? It may not be obvious to all readers.

That said, I’m not sure this trick will actually change the generated 
object code - especially if the result of the eq function is still used 
in a conditional afterward. Anyway, keeping it seems like a good 
conservative approach.

> +
> +static inline int
> +rte_hash_k4_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
> +{
> +	const uint32_t *k1 = key1;
> +	const uint32_t *k2 = key2;
> +
> +	return k1[0] ^ k2[0];
> +}
> +
> +static inline int
> +rte_hash_k6_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
> +{
> +	const uint16_t *k1 = key1;
> +	const uint16_t *k2 = key2;
> +
> +	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]);
> +}
> +
> +static inline int
> +rte_hash_k8_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
> +{
> +	const uint64_t *k1 = key1;
> +	const uint64_t *k2 = key2;
> +
> +	return k1[0] ^ k2[0];
> +}
> +
> +static inline int
> +rte_hash_k12_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
> +{
> +	const uint32_t *k1 = key1;
> +	const uint32_t *k2 = key2;
> +
> +	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]);
> +}
>   
>   static inline int
>   rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
> @@ -228,6 +277,11 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
>    */
>   static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
>   	[KEY_CUSTOM] = NULL,
> +	[KEY_2_BYTES] = rte_hash_k2_cmp_eq,
> +	[KEY_4_BYTES] = rte_hash_k4_cmp_eq,
> +	[KEY_6_BYTES] = rte_hash_k6_cmp_eq,
> +	[KEY_8_BYTES] = rte_hash_k8_cmp_eq,
> +	[KEY_12_BYTES] = rte_hash_k12_cmp_eq,
>   	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
>   	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
>   	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,

