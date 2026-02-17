Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A90E83849
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 06:37:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CCFB402A2;
	Tue, 17 Feb 2026 07:37:18 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 5C2CF4029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:37:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru CCF8450
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1771310236;
 bh=TdVYVeHnK5J7jtzsWW2SpU0RlTsAWkSOaKHe+a2h4P8=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=bpsgY5TfWxUOO/DbofZCWuH1Zyh0curQ8JsYdi8DwyCXhjnSCL7J+ZU7twjP9xLy0
 vrXP4n3a8jD6/kYJcSxGxMV/PwPXR+6HIrRG4WY7voyFHx70NPXpOBNaaUEp3MgyHK
 DFawN/WXklxc0Ol1vXx2FT1AecjTrgR78l/aHjXM=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id CCF8450;
 Tue, 17 Feb 2026 09:37:16 +0300 (MSK)
Message-ID: <9cd2da33-d324-419e-af42-4a3ff8804ff0@oktetlabs.ru>
Date: Tue, 17 Feb 2026 09:37:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] mempool: de-inline get/put unlikely code paths
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org
References: <20260216115813.103515-1-mb@smartsharesystems.com>
 <20260216152320.105312-1-mb@smartsharesystems.com>
 <20260216152320.105312-3-mb@smartsharesystems.com>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20260216152320.105312-3-mb@smartsharesystems.com>
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

On 2/16/26 6:23 PM, Morten Brørup wrote:
> De-inline unlikely code paths, for smaller footprint.

The idea is interesting and makes sense to me. But could you share
performance figures to know the impact.

> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> v3:
> * New functions are called from inline code, so make them experimental
>    instead of internal.
> v2:
> * Removed review functions.
> * Changed #if 0 to #if AVOID_RTE_MEMCPY.
> ---
>   lib/mempool/rte_mempool.c | 112 ++++++++++++++++++++
>   lib/mempool/rte_mempool.h | 212 ++++++++++++++++++++------------------
>   2 files changed, 223 insertions(+), 101 deletions(-)
> 
> diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
> index 3042d94c14..30dce3a2fd 100644
> --- a/lib/mempool/rte_mempool.c
> +++ b/lib/mempool/rte_mempool.c
> @@ -1016,6 +1016,118 @@ rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
>   	return NULL;
>   }
>   
> +/* internal */
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(_rte_mempool_do_generic_put_more, 26.03)
> +void
> +_rte_mempool_do_generic_put_more(struct rte_mempool *mp, void * const *obj_table,
> +		unsigned int n, struct rte_mempool_cache *cache)
> +{

I'd add comments which explain why stats are not updated by the
function. It is the drawback of the solution when at least
comments should be added to make it clear. Stats update would
be very easy to loose in the case of future changes.

> +	__rte_assume(cache->flushthresh <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> +	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> +	__rte_assume(cache->len <= cache->flushthresh);
> +	__rte_assume(cache->len + n > cache->flushthresh);
> +	if (likely(n <= cache->flushthresh)) {
> +		uint32_t len;
> +		void **cache_objs;
> +
> +		/*
> +		 * The cache is big enough for the objects, but - as detected by
> +		 * rte_mempool_do_generic_put() - has insufficient room for them.
> +		 * Flush the cache to make room for the objects.
> +		 */
> +		len = cache->len;
> +		cache_objs = &cache->objs[0];
> +		cache->len = n;
> +		rte_mempool_ops_enqueue_bulk(mp, cache_objs, len);
> +
> +		/* Add the objects to the cache. */
> +#ifdef AVOID_RTE_MEMCPY /* Simple alternative to rte_memcpy(). */

I'd not mix introduction of AVOID_RTE_MEMCPY and other goals of the
patch. If AVOID_RTE_MEMCPY is really useful, it could be added
separately and appropriately motivated.

> +		for (uint32_t index = 0; index < n; index++)
> +			*cache_objs++ = *obj_table++;
> +#else
> +		rte_memcpy(cache_objs, obj_table, sizeof(void *) * n);
> +#endif
> +
> +		return;
> +	}
> +
> +	/* The request itself is too big for the cache. Push objects directly to the backend. */
> +	rte_mempool_ops_enqueue_bulk(mp, obj_table, n);
> +}
> +
> +/* internal */
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(_rte_mempool_do_generic_get_more, 26.03)
> +int
> +_rte_mempool_do_generic_get_more(struct rte_mempool *mp, void **obj_table,
> +		unsigned int n, struct rte_mempool_cache *cache)
> +{
> +	int ret;
> +	unsigned int remaining;
> +	uint32_t index, len;
> +	void **cache_objs;
> +
> +	/* Use the cache as much as we have to return hot objects first. */
> +	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> +	len = cache->len;
> +	remaining = n - len;
> +	cache_objs = &cache->objs[len];
> +	cache->len = 0;
> +	for (index = 0; index < len; index++)
> +		*obj_table++ = *--cache_objs;
> +
> +	/* Dequeue below would overflow mem allocated for cache? */
> +	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
> +		goto driver_dequeue;
> +
> +	/* Fill the cache from the backend; fetch size + remaining objects. */
> +	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs,
> +			cache->size + remaining);
> +	if (unlikely(ret < 0)) {
> +		/*
> +		 * We are buffer constrained, and not able to fetch all that.
> +		 * Do not fill the cache, just satisfy the remaining part of
> +		 * the request directly from the backend.
> +		 */
> +		goto driver_dequeue;
> +	}
> +
> +	/* Satisfy the remaining part of the request from the filled cache. */
> +	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> +	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> +
> +	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> +	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> +	cache_objs = &cache->objs[cache->size + remaining];
> +	cache->len = cache->size;
> +	for (index = 0; index < remaining; index++)
> +		*obj_table++ = *--cache_objs;
> +
> +	return 0;
> +
> +driver_dequeue:
> +
> +	/* Get remaining objects directly from the backend. */
> +	ret = rte_mempool_ops_dequeue_bulk(mp, obj_table, remaining);
> +
> +	if (unlikely(ret < 0)) {
> +		cache->len = n - remaining;
> +		/*
> +		 * No further action is required to roll the first part
> +		 * of the request back into the cache, as objects in
> +		 * the cache are intact.
> +		 */
> +
> +		RTE_MEMPOOL_STAT_ADD(mp, get_fail_bulk, 1);
> +		RTE_MEMPOOL_STAT_ADD(mp, get_fail_objs, n);
> +	} else {
> +		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> +		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> +		__rte_assume(ret == 0);
> +	}
> +
> +	return ret;
> +}
> +
>   /* Return the number of entries in the mempool */
>   RTE_EXPORT_SYMBOL(rte_mempool_avail_count)
>   unsigned int
> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index 7989d7a475..c6df285194 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -1370,8 +1370,31 @@ rte_mempool_cache_flush(struct rte_mempool_cache *cache,
>   	cache->len = 0;
>   }
>   
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @internal
> + * Put several objects back in the mempool, more than the cache has room for; used internally.
> + *
> + * @param mp
> + *   A pointer to the mempool structure.
> + * @param obj_table
> + *   A pointer to a table of void * pointers (objects).
> + * @param n
> + *   The number of objects to store back in the mempool, must be strictly
> + *   positive.
> + * @param cache
> + *   A pointer to a mempool cache structure.
> + */
> +__rte_experimental
> +void
> +_rte_mempool_do_generic_put_more(struct rte_mempool *mp, void * const *obj_table,
> +		unsigned int n, struct rte_mempool_cache *cache);
> +
>   /**
>    * @internal Put several objects back in the mempool; used internally.
> + *
>    * @param mp
>    *   A pointer to the mempool structure.
>    * @param obj_table
> @@ -1388,9 +1411,16 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
>   {
>   	void **cache_objs;
>   
> -	/* No cache provided? */
> -	if (unlikely(cache == NULL))
> -		goto driver_enqueue;
> +	if (unlikely(cache == NULL)) {

Patch summary says about de-inline of unlikely code, but you still have
it here. May be it is better to be consistent and the case in de-line
code.

> +		/* No cache. Push objects directly to the backend. */
> +		/* Increment stats now, adding in mempool always succeeds. */
> +		RTE_MEMPOOL_STAT_ADD(mp, put_bulk, 1);
> +		RTE_MEMPOOL_STAT_ADD(mp, put_objs, n);
> +
> +		rte_mempool_ops_enqueue_bulk(mp, obj_table, n);
> +
> +		return;
> +	}
>   
>   	/* Increment stats now, adding in mempool always succeeds. */
>   	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
> @@ -1403,35 +1433,43 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
>   		/* Sufficient room in the cache for the objects. */
>   		cache_objs = &cache->objs[cache->len];
>   		cache->len += n;
> -	} else if (n <= cache->flushthresh) {
> +
> +cache_enqueue:
> +#ifdef AVOID_RTE_MEMCPY /* Simple alternative to rte_memcpy(). */
>   		/*
> -		 * The cache is big enough for the objects, but - as detected by
> -		 * the comparison above - has insufficient room for them.
> -		 * Flush the cache to make room for the objects.
> +		 * Add the objects to the cache.
> +		 * If the request size is known at build time,
> +		 * the compiler unrolls the fixed length copy loop.
>   		 */
> -		cache_objs = &cache->objs[0];
> -		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->len);
> -		cache->len = n;
> -	} else {
> -		/* The request itself is too big for the cache. */
> -		goto driver_enqueue_stats_incremented;
> -	}
> -
> -	/* Add the objects to the cache. */
> -	rte_memcpy(cache_objs, obj_table, sizeof(void *) * n);
> +		for (uint32_t index = 0; index < n; index++)
> +			*cache_objs++ = *obj_table++;
> +#else
> +		/* Add the objects to the cache. */
> +		rte_memcpy(cache_objs, obj_table, sizeof(void *) * n);
> +#endif
>   
> -	return;
> +		return;
> +	}
>   
> -driver_enqueue:
> +	if (__rte_constant(n) && likely(n <= cache->flushthresh)) {
> +		uint32_t len;
>   
> -	/* increment stat now, adding in mempool always success */
> -	RTE_MEMPOOL_STAT_ADD(mp, put_bulk, 1);
> -	RTE_MEMPOOL_STAT_ADD(mp, put_objs, n);
> +		/*
> +		 * The cache is big enough for the objects, but - as detected
> +		 * above - has insufficient room for them.
> +		 * Flush the cache to make room for the objects.
> +		 */
> +		len = cache->len;
> +		cache_objs = &cache->objs[0];
> +		cache->len = n;
> +		rte_mempool_ops_enqueue_bulk(mp, cache_objs, len);
>   
> -driver_enqueue_stats_incremented:
> +		/* Add the objects to the cache. */
> +		goto cache_enqueue;
> +	}
>   
> -	/* push objects to the backend */
> -	rte_mempool_ops_enqueue_bulk(mp, obj_table, n);
> +	/* Insufficient room in the cache for the objects. */
> +	_rte_mempool_do_generic_put_more(mp, obj_table, n, cache);
>   }
>   
>   
> @@ -1498,8 +1536,33 @@ rte_mempool_put(struct rte_mempool *mp, void *obj)
>   	rte_mempool_put_bulk(mp, &obj, 1);
>   }
>   
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @internal
> + * Get several objects from the mempool, more than held in the cache; used internally.
> + *
> + * @param mp
> + *   A pointer to the mempool structure.
> + * @param obj_table
> + *   A pointer to a table of void * pointers (objects).
> + * @param n
> + *   The number of objects to get, must be strictly positive.
> + * @param cache
> + *   A pointer to a mempool cache structure.
> + * @return
> + *   - 0: Success.
> + *   - <0: Error; code of driver dequeue function.
> + */
> +__rte_experimental
> +int
> +_rte_mempool_do_generic_get_more(struct rte_mempool *mp, void **obj_table,
> +		unsigned int n, struct rte_mempool_cache *cache);
> +
>   /**
>    * @internal Get several objects from the mempool; used internally.
> + *
>    * @param mp
>    *   A pointer to the mempool structure.
>    * @param obj_table
> @@ -1516,26 +1579,36 @@ static __rte_always_inline int
>   rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
>   			   unsigned int n, struct rte_mempool_cache *cache)
>   {
> -	int ret;
> -	unsigned int remaining;
> -	uint32_t index, len;
> -	void **cache_objs;
> -
> -	/* No cache provided? */
>   	if (unlikely(cache == NULL)) {

Patch summary says about de-inline of unlikely code, but you still have
it here.

> -		remaining = n;
> -		goto driver_dequeue;
> -	}
> +		int ret;
> +
> +		/* No cache. Get objects directly from the backend. */
> +		ret = rte_mempool_ops_dequeue_bulk(mp, obj_table, n);
> +
> +		if (unlikely(ret < 0)) {
> +			RTE_MEMPOOL_STAT_ADD(mp, get_fail_bulk, 1);
> +			RTE_MEMPOOL_STAT_ADD(mp, get_fail_objs, n);
> +		} else {
> +			RTE_MEMPOOL_STAT_ADD(mp, get_success_bulk, 1);
> +			RTE_MEMPOOL_STAT_ADD(mp, get_success_objs, n);
> +			__rte_assume(ret == 0);
> +		}
>   
> -	/* The cache is a stack, so copy will be in reverse order. */
> -	cache_objs = &cache->objs[cache->len];
> +		return ret;
> +	}
>   
>   	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
>   	if (likely(n <= cache->len)) {
> +		uint32_t index;
> +		void **cache_objs;
> +
>   		/* The entire request can be satisfied from the cache. */
>   		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
>   		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
>   
> +		/* The cache is a stack, so copy will be in reverse order. */
> +		cache_objs = &cache->objs[cache->len];
> +
>   		/*
>   		 * If the request size is known at build time,
>   		 * the compiler unrolls the fixed length copy loop.
> @@ -1547,71 +1620,8 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
>   		return 0;
>   	}
>   
> -	/* Use the cache as much as we have to return hot objects first. */
> -	len = cache->len;
> -	remaining = n - len;
> -	cache->len = 0;
> -	for (index = 0; index < len; index++)
> -		*obj_table++ = *--cache_objs;
> -
> -	/* Dequeue below would overflow mem allocated for cache? */
> -	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
> -		goto driver_dequeue;
> -
> -	/* Fill the cache from the backend; fetch size + remaining objects. */
> -	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs,
> -			cache->size + remaining);
> -	if (unlikely(ret < 0)) {
> -		/*
> -		 * We are buffer constrained, and not able to fetch all that.
> -		 * Do not fill the cache, just satisfy the remaining part of
> -		 * the request directly from the backend.
> -		 */
> -		goto driver_dequeue;
> -	}
> -
> -	/* Satisfy the remaining part of the request from the filled cache. */
> -	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> -	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> -
> -	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> -	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> -	cache_objs = &cache->objs[cache->size + remaining];
> -	cache->len = cache->size;
> -	for (index = 0; index < remaining; index++)
> -		*obj_table++ = *--cache_objs;
> -
> -	return 0;
> -
> -driver_dequeue:
> -
> -	/* Get remaining objects directly from the backend. */
> -	ret = rte_mempool_ops_dequeue_bulk(mp, obj_table, remaining);
> -
> -	if (unlikely(ret < 0)) {
> -		if (likely(cache != NULL)) {
> -			cache->len = n - remaining;
> -			/*
> -			 * No further action is required to roll the first part
> -			 * of the request back into the cache, as objects in
> -			 * the cache are intact.
> -			 */
> -		}
> -
> -		RTE_MEMPOOL_STAT_ADD(mp, get_fail_bulk, 1);
> -		RTE_MEMPOOL_STAT_ADD(mp, get_fail_objs, n);
> -	} else {
> -		if (likely(cache != NULL)) {
> -			RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> -			RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> -		} else {
> -			RTE_MEMPOOL_STAT_ADD(mp, get_success_bulk, 1);
> -			RTE_MEMPOOL_STAT_ADD(mp, get_success_objs, n);
> -		}
> -		__rte_assume(ret == 0);
> -	}
> -
> -	return ret;
> +	/* The entire request cannot be satisfied from the cache. */
> +	return _rte_mempool_do_generic_get_more(mp, obj_table, n, cache);
>   }
>   
>   /**

