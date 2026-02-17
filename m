Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E4FE83857
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 06:19:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44F5F402A2;
	Tue, 17 Feb 2026 07:19:13 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 7DCFD4029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:19:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 5710750
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1771309151;
 bh=JUH+ysS1EyjOtV2SXJPWepq1aj1QLzASthy0jZ+1hkk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=QWGEismJiirhv7AVb2QIcJD8oINROJJnLGVpeKZFv3aS2qPXK4BeGbGoQV13FLjzD
 W+AXxayESwssIwAvyG5ZA/xqwE1FiLI73Wu0WcEnXT8QqDgBLu9viW547dDoKznyn/
 Uw33pTbYz2pQ3OsQrh4lkKk61shsS+LtqdM/fpUI=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 5710750;
 Tue, 17 Feb 2026 09:19:11 +0300 (MSK)
Message-ID: <24cc7908-f8f4-4bbe-944f-885169f0f68b@oktetlabs.ru>
Date: Tue, 17 Feb 2026 09:19:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/2] mempool: simplify get objects
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org
References: <20260216115813.103515-1-mb@smartsharesystems.com>
 <20260216152320.105312-1-mb@smartsharesystems.com>
 <20260216152320.105312-2-mb@smartsharesystems.com>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20260216152320.105312-2-mb@smartsharesystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Morten,

On 2/16/26 6:23 PM, Morten Brørup wrote:
> Removed explicit test for build time constant request size,
> and added comment that the compiler loop unrolls when request size is
> build time constant, to improve source code readability.
> 
> Moved setting cache->len up before the copy loop; not only for code
> similarity (cache->len is now set before each copy loop), but also as an
> optimization:
> The function's pointer parameters are not marked restrict, so writing to
> obj_table in the copy loop might formally modify cache->size. And thus,
> setting cache->len = cache->size after the copy loop requires loading
> cache->size again after copying the objects.
> Moving this line up before the copy loop avoids that extra load of
> cache->size when setting cache->len.
> 
> Similarly, moved statistics update up before the copy loops.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

LGTM, the result looks simpler, easier to read and understand.
If there is no measurable performance degradation after the patch

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

> ---
> v3:
> * Added to description why setting cache->len was moved up before the copy
>    loop.
> * Moved statistics update up before the copy loop.
> v2:
> * Removed unrelated microoptimization from rte_mempool_do_generic_put(),
>    which was also described incorrectly.
> ---
>   lib/mempool/rte_mempool.h | 47 ++++++++++++---------------------------
>   1 file changed, 14 insertions(+), 33 deletions(-)
> 
> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index aedc100964..7989d7a475 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -1531,47 +1531,29 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
>   	cache_objs = &cache->objs[cache->len];
>   
>   	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> -	if (__rte_constant(n) && n <= cache->len) {
> +	if (likely(n <= cache->len)) {
> +		/* The entire request can be satisfied from the cache. */
> +		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> +		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> +
>   		/*
> -		 * The request size is known at build time, and
> -		 * the entire request can be satisfied from the cache,
> -		 * so let the compiler unroll the fixed length copy loop.
> +		 * If the request size is known at build time,
> +		 * the compiler unrolls the fixed length copy loop.
>   		 */
>   		cache->len -= n;
>   		for (index = 0; index < n; index++)
>   			*obj_table++ = *--cache_objs;
>   
> -		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> -		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> -
>   		return 0;
>   	}
>   
> -	/*
> -	 * Use the cache as much as we have to return hot objects first.
> -	 * If the request size 'n' is known at build time, the above comparison
> -	 * ensures that n > cache->len here, so omit RTE_MIN().
> -	 */
> -	len = __rte_constant(n) ? cache->len : RTE_MIN(n, cache->len);
> -	cache->len -= len;
> +	/* Use the cache as much as we have to return hot objects first. */
> +	len = cache->len;
>   	remaining = n - len;
> +	cache->len = 0;
>   	for (index = 0; index < len; index++)
>   		*obj_table++ = *--cache_objs;
>   
> -	/*
> -	 * If the request size 'n' is known at build time, the case
> -	 * where the entire request can be satisfied from the cache
> -	 * has already been handled above, so omit handling it here.
> -	 */
> -	if (!__rte_constant(n) && likely(remaining == 0)) {
> -		/* The entire request is satisfied from the cache. */
> -
> -		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> -		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> -
> -		return 0;
> -	}
> -
>   	/* Dequeue below would overflow mem allocated for cache? */
>   	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
>   		goto driver_dequeue;
> @@ -1589,17 +1571,16 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
>   	}
>   
>   	/* Satisfy the remaining part of the request from the filled cache. */
> +	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> +	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> +
>   	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
>   	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
>   	cache_objs = &cache->objs[cache->size + remaining];
> +	cache->len = cache->size;
>   	for (index = 0; index < remaining; index++)
>   		*obj_table++ = *--cache_objs;
>   
> -	cache->len = cache->size;
> -
> -	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> -	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> -
>   	return 0;
>   
>   driver_dequeue:

