Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A28C28B20
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Mar 2025 08:29:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FF26402AB;
	Sun, 30 Mar 2025 10:29:24 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 1AF01402A4
 for <dev@dpdk.org>; Sun, 30 Mar 2025 10:29:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 1E87541
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1743323362;
 bh=MJ6bFampYMZ6Ed3ie7Teoq+bqSjqseLwci9QJmb15kE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=TailYB9uHV/iNeBAkam27LZplLvpdkU0O/yqANsE3qDr63l8N9o+OWuQjJB3yp81n
 /3vY7DuOcAGT+tRBJPOuFS/P6mmxryo4SWaIfxsCatc+7aOPsScT8QXbY40mjlHuVg
 EfVmp/fDbevFetTCeF6ksy+DVOTBLZokw1tNAy1s=
Received: from [192.168.1.38] (unknown [188.170.78.30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 1E87541;
 Sun, 30 Mar 2025 11:29:22 +0300 (MSK)
Message-ID: <0ec8a97b-6668-424a-a375-e5c660219835@oktetlabs.ru>
Date: Sun, 30 Mar 2025 11:29:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempool perf test: test random bulk sizes
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
References: <20250228164858.274204-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250228164858.274204-1-mb@smartsharesystems.com>
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

On 2/28/25 19:48, Morten Brørup wrote:
> Bulk requests to get or put objects in a mempool often vary in size.
> A series of tests with pseudo random request sizes, to mitigate the
> benefits of the CPU's dynamic branch predictor, was added.
> 
> Also, various other minor changes:
> - Improved the output formatting for readability.
> - Added test for the "default" mempool with cache.
> - Skip the tests for the "default" mempool, if it happens to use the same
>    driver (i.e. operations) as already tested.
> - Replaced bare use of "unsigned" with "unsigned int",
>    to make checkpatches happy.

IMHO, it would be much better and easier to review if all above changes
are done one by one in separate patches.

> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Overall the idea looks good, so
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

but I'd be thankful if you split the patch.

> ---
>   app/test/test_mempool_perf.c | 219 +++++++++++++++++++++++++++--------
>   1 file changed, 172 insertions(+), 47 deletions(-)
> 
> diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
> index 4dd74ef75a..5e29797f02 100644
> --- a/app/test/test_mempool_perf.c
> +++ b/app/test/test_mempool_perf.c
> @@ -33,6 +33,13 @@
>    * Mempool performance
>    * =======
>    *
> + *    Each core get *n_keep* objects per bulk of a pseudorandom number
> + *    between 1 and *n_max_bulk*.
> + *    Objects are put back in the pool per bulk of a similar pseudorandom number.
> + *    Note: The very low entropy of the randomization algorithm is harmless, because
> + *          the sole purpose of randomization is to prevent the CPU's dynamic branch
> + *          predictor from enhancing the test results.
> + *
>    *    Each core get *n_keep* objects per bulk of *n_get_bulk*. Then,
>    *    objects are put back in the pool per bulk of *n_put_bulk*.
>    *
> @@ -52,7 +59,12 @@
>    *      - Two cores with user-owned cache
>    *      - Max. cores with user-owned cache
>    *
> - *    - Bulk size (*n_get_bulk*, *n_put_bulk*)
> + *    - Pseudorandom max bulk size (*n_max_bulk*)
> + *
> + *      - Max bulk from CACHE_LINE_BURST to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE,
> + *        where CACHE_LINE_BURST is the number of pointers fitting into one CPU cache line.
> + *
> + *    - Fixed bulk size (*n_get_bulk*, *n_put_bulk*)
>    *
>    *      - Bulk get from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
>    *      - Bulk put from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
> @@ -89,16 +101,19 @@
>   	} while (0)
>   
>   static int use_external_cache;
> -static unsigned external_cache_size = RTE_MEMPOOL_CACHE_MAX_SIZE;
> +static unsigned int external_cache_size = RTE_MEMPOOL_CACHE_MAX_SIZE;
>   
>   static RTE_ATOMIC(uint32_t) synchro;
>   
> +/* max random number of objects in one bulk operation (get and put) */
> +static unsigned int n_max_bulk;
> +
>   /* number of objects in one bulk operation (get or put) */
> -static unsigned n_get_bulk;
> -static unsigned n_put_bulk;
> +static unsigned int n_get_bulk;
> +static unsigned int n_put_bulk;
>   
>   /* number of objects retrieved from mempool before putting them back */
> -static unsigned n_keep;
> +static unsigned int n_keep;
>   
>   /* true if we want to test with constant n_get_bulk and n_put_bulk */
>   static int use_constant_values;
> @@ -118,7 +133,7 @@ static struct mempool_test_stats stats[RTE_MAX_LCORE];
>    */
>   static void
>   my_obj_init(struct rte_mempool *mp, __rte_unused void *arg,
> -	    void *obj, unsigned i)
> +	    void *obj, unsigned int i)
>   {
>   	uint32_t *objnum = obj;
>   	memset(obj, 0, mp->elt_size);
> @@ -159,11 +174,55 @@ test_loop(struct rte_mempool *mp, struct rte_mempool_cache *cache,
>   	return 0;
>   }
>   
> +static __rte_always_inline int
> +test_loop_random(struct rte_mempool *mp, struct rte_mempool_cache *cache,
> +	  unsigned int x_keep, unsigned int x_max_bulk)
> +{
> +	alignas(RTE_CACHE_LINE_SIZE) void *obj_table[MAX_KEEP];
> +	unsigned int idx;
> +	unsigned int i;
> +	unsigned int r = 0;
> +	unsigned int x_bulk;
> +	int ret;
> +
> +	for (i = 0; likely(i < (N / x_keep)); i++) {
> +		/* get x_keep objects by bulk of random [1 .. x_max_bulk] */
> +		for (idx = 0; idx < x_keep; idx += x_bulk, r++) {
> +			/* Generate a pseudorandom number [1 .. x_max_bulk]. */
> +			x_bulk = ((r ^ (r >> 2) ^ (r << 3)) & (x_max_bulk - 1)) + 1;
> +			if (unlikely(idx + x_bulk > x_keep))
> +				x_bulk = x_keep - idx;
> +			ret = rte_mempool_generic_get(mp,
> +						      &obj_table[idx],
> +						      x_bulk,
> +						      cache);
> +			if (unlikely(ret < 0)) {
> +				rte_mempool_dump(stdout, mp);
> +				return ret;
> +			}
> +		}
> +
> +		/* put the objects back by bulk of random [1 .. x_max_bulk] */
> +		for (idx = 0; idx < x_keep; idx += x_bulk, r++) {
> +			/* Generate a pseudorandom number [1 .. x_max_bulk]. */
> +			x_bulk = ((r ^ (r >> 2) ^ (r << 3)) & (x_max_bulk - 1)) + 1;
> +			if (unlikely(idx + x_bulk > x_keep))
> +				x_bulk = x_keep - idx;
> +			rte_mempool_generic_put(mp,
> +						&obj_table[idx],
> +						x_bulk,
> +						cache);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   per_lcore_mempool_test(void *arg)
>   {
>   	struct rte_mempool *mp = arg;
> -	unsigned lcore_id = rte_lcore_id();
> +	unsigned int lcore_id = rte_lcore_id();
>   	int ret = 0;
>   	uint64_t start_cycles, end_cycles;
>   	uint64_t time_diff = 0, hz = rte_get_timer_hz();
> @@ -181,9 +240,9 @@ per_lcore_mempool_test(void *arg)
>   	}
>   
>   	/* n_get_bulk and n_put_bulk must be divisors of n_keep */
> -	if (((n_keep / n_get_bulk) * n_get_bulk) != n_keep)
> +	if (!n_max_bulk && (((n_keep / n_get_bulk) * n_get_bulk) != n_keep))
>   		GOTO_ERR(ret, out);
> -	if (((n_keep / n_put_bulk) * n_put_bulk) != n_keep)
> +	if (!n_max_bulk && (((n_keep / n_put_bulk) * n_put_bulk) != n_keep))
>   		GOTO_ERR(ret, out);
>   	/* for constant n, n_get_bulk and n_put_bulk must be the same */
>   	if (use_constant_values && n_put_bulk != n_get_bulk)
> @@ -200,7 +259,9 @@ per_lcore_mempool_test(void *arg)
>   	start_cycles = rte_get_timer_cycles();
>   
>   	while (time_diff/hz < TIME_S) {
> -		if (!use_constant_values)
> +		if (n_max_bulk)
> +			ret = test_loop_random(mp, cache, n_keep, n_max_bulk);
> +		else if (!use_constant_values)
>   			ret = test_loop(mp, cache, n_keep, n_get_bulk, n_put_bulk);
>   		else if (n_get_bulk == 1)
>   			ret = test_loop(mp, cache, n_keep, 1, 1);
> @@ -246,10 +307,10 @@ per_lcore_mempool_test(void *arg)
>   static int
>   launch_cores(struct rte_mempool *mp, unsigned int cores)
>   {
> -	unsigned lcore_id;
> +	unsigned int lcore_id;
>   	uint64_t rate;
>   	int ret;
> -	unsigned cores_save = cores;
> +	unsigned int cores_save = cores;
>   	double hz = rte_get_timer_hz();
>   
>   	rte_atomic_store_explicit(&synchro, 0, rte_memory_order_relaxed);
> @@ -257,11 +318,18 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
>   	/* reset stats */
>   	memset(stats, 0, sizeof(stats));
>   
> -	printf("mempool_autotest cache=%u cores=%u n_get_bulk=%u "
> -	       "n_put_bulk=%u n_keep=%u constant_n=%u ",
> +	printf("mempool_autotest cache=%u cores=%u n_keep=%5u ",
>   	       use_external_cache ?
>   		   external_cache_size : (unsigned) mp->cache_size,
> -	       cores, n_get_bulk, n_put_bulk, n_keep, use_constant_values);
> +	       cores,
> +	       n_keep);
> +	if (n_max_bulk)
> +		printf("n_max_bulk=%3u ",
> +		       n_max_bulk);
> +	else
> +		printf("n_get_bulk=%3u n_put_bulk=%3u constant_n=%u ",
> +		       n_get_bulk, n_put_bulk,
> +		       use_constant_values);
>   
>   	if (rte_mempool_avail_count(mp) != MEMPOOL_SIZE) {
>   		printf("mempool is not full\n");
> @@ -301,7 +369,7 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
>   			rate += (double)stats[lcore_id].enq_count * hz /
>   					(double)stats[lcore_id].duration_cycles;
>   
> -	printf("rate_persec=%" PRIu64 "\n", rate);
> +	printf("rate_persec=%10" PRIu64 "\n", rate);
>   
>   	return 0;
>   }
> @@ -310,25 +378,47 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
>   static int
>   do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cache)
>   {
> +	unsigned int bulk_tab_max[] = { CACHE_LINE_BURST, 32, 64, 128, 256,
> +			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
>   	unsigned int bulk_tab_get[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
>   			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
>   	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
>   			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
>   	unsigned int keep_tab[] = { 32, 128, 512, 2048, 8192, 32768, 0 };
> -	unsigned *get_bulk_ptr;
> -	unsigned *put_bulk_ptr;
> -	unsigned *keep_ptr;
> +	unsigned int *max_bulk_ptr;
> +	unsigned int *get_bulk_ptr;
> +	unsigned int *put_bulk_ptr;
> +	unsigned int *keep_ptr;
>   	int ret;
>   
> -	for (get_bulk_ptr = bulk_tab_get; *get_bulk_ptr; get_bulk_ptr++) {
> -		for (put_bulk_ptr = bulk_tab_put; *put_bulk_ptr; put_bulk_ptr++) {
> -			for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
> +	for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
> +		for (max_bulk_ptr = bulk_tab_max; *max_bulk_ptr; max_bulk_ptr++) {
> +
> +			if (*keep_ptr < *max_bulk_ptr)
> +				continue;
> +
> +			use_external_cache = external_cache;
> +			use_constant_values = 0;
> +			n_max_bulk = *max_bulk_ptr;
> +			n_get_bulk = 0;
> +			n_put_bulk = 0;
> +			n_keep = *keep_ptr;
> +			ret = launch_cores(mp, cores);
> +			if (ret < 0)
> +				return -1;
> +		}
> +	}
> +
> +	for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
> +		for (get_bulk_ptr = bulk_tab_get; *get_bulk_ptr; get_bulk_ptr++) {
> +			for (put_bulk_ptr = bulk_tab_put; *put_bulk_ptr; put_bulk_ptr++) {
>   
>   				if (*keep_ptr < *get_bulk_ptr || *keep_ptr < *put_bulk_ptr)
>   					continue;
>   
>   				use_external_cache = external_cache;
>   				use_constant_values = 0;
> +				n_max_bulk = 0;
>   				n_get_bulk = *get_bulk_ptr;
>   				n_put_bulk = *put_bulk_ptr;
>   				n_keep = *keep_ptr;
> @@ -346,6 +436,7 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
>   			}
>   		}
>   	}
> +
>   	return 0;
>   }
>   
> @@ -354,7 +445,10 @@ do_all_mempool_perf_tests(unsigned int cores)
>   {
>   	struct rte_mempool *mp_cache = NULL;
>   	struct rte_mempool *mp_nocache = NULL;
> -	struct rte_mempool *default_pool = NULL;
> +	struct rte_mempool *default_pool_cache = NULL;
> +	struct rte_mempool *default_pool_nocache = NULL;
> +	const char *mp_cache_ops;
> +	const char *mp_nocache_ops;
>   	const char *default_pool_ops;
>   	int ret = -1;
>   
> @@ -368,6 +462,7 @@ do_all_mempool_perf_tests(unsigned int cores)
>   		printf("cannot allocate mempool (without cache)\n");
>   		goto err;
>   	}
> +	mp_nocache_ops = rte_mempool_get_ops(mp_nocache->ops_index)->name;
>   
>   	/* create a mempool (with cache) */
>   	mp_cache = rte_mempool_create("perf_test_cache", MEMPOOL_SIZE,
> @@ -380,47 +475,76 @@ do_all_mempool_perf_tests(unsigned int cores)
>   		printf("cannot allocate mempool (with cache)\n");
>   		goto err;
>   	}
> +	mp_cache_ops = rte_mempool_get_ops(mp_cache->ops_index)->name;
>   
>   	default_pool_ops = rte_mbuf_best_mempool_ops();
> -	/* Create a mempool based on Default handler */
> -	default_pool = rte_mempool_create_empty("default_pool",
> -						MEMPOOL_SIZE,
> -						MEMPOOL_ELT_SIZE,
> -						0, 0,
> -						SOCKET_ID_ANY, 0);
> -
> -	if (default_pool == NULL) {
> -		printf("cannot allocate %s mempool\n", default_pool_ops);
> +
> +	/* Create a mempool (without cache) based on Default handler */
> +	default_pool_nocache = rte_mempool_create_empty("default_pool_nocache",
> +			MEMPOOL_SIZE,
> +			MEMPOOL_ELT_SIZE,
> +			0, 0,
> +			SOCKET_ID_ANY, 0);
> +	if (default_pool_nocache == NULL) {
> +		printf("cannot allocate %s mempool (without cache)\n", default_pool_ops);
>   		goto err;
>   	}
> -
> -	if (rte_mempool_set_ops_byname(default_pool, default_pool_ops, NULL)
> -				       < 0) {
> +	if (rte_mempool_set_ops_byname(default_pool_nocache, default_pool_ops, NULL) < 0) {
>   		printf("cannot set %s handler\n", default_pool_ops);
>   		goto err;
>   	}
> -
> -	if (rte_mempool_populate_default(default_pool) < 0) {
> +	if (rte_mempool_populate_default(default_pool_nocache) < 0) {
>   		printf("cannot populate %s mempool\n", default_pool_ops);
>   		goto err;
>   	}
> +	rte_mempool_obj_iter(default_pool_nocache, my_obj_init, NULL);
> +
> +	/* Create a mempool (with cache) based on Default handler */
> +	default_pool_cache = rte_mempool_create_empty("default_pool_cache",
> +			MEMPOOL_SIZE,
> +			MEMPOOL_ELT_SIZE,
> +			RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
> +			SOCKET_ID_ANY, 0);
> +	if (default_pool_cache == NULL) {
> +		printf("cannot allocate %s mempool (with cache)\n", default_pool_ops);
> +		goto err;
> +	}
> +	if (rte_mempool_set_ops_byname(default_pool_cache, default_pool_ops, NULL) < 0) {
> +		printf("cannot set %s handler\n", default_pool_ops);
> +		goto err;
> +	}
> +	if (rte_mempool_populate_default(default_pool_cache) < 0) {
> +		printf("cannot populate %s mempool\n", default_pool_ops);
> +		goto err;
> +	}
> +	rte_mempool_obj_iter(default_pool_cache, my_obj_init, NULL);
>   
> -	rte_mempool_obj_iter(default_pool, my_obj_init, NULL);
> -
> -	printf("start performance test (without cache)\n");
> +	printf("start performance test (using %s, without cache)\n",
> +	       mp_nocache_ops);
>   	if (do_one_mempool_test(mp_nocache, cores, 0) < 0)
>   		goto err;
>   
> -	printf("start performance test for %s (without cache)\n",
> -	       default_pool_ops);
> -	if (do_one_mempool_test(default_pool, cores, 0) < 0)
> -		goto err;
> +	if (strcmp(default_pool_ops, mp_nocache_ops) != 0) {
> +		printf("start performance test for %s (without cache)\n",
> +		       default_pool_ops);
> +		if (do_one_mempool_test(default_pool_nocache, cores, 0) < 0)
> +			goto err;
> +	}
>   
> -	printf("start performance test (with cache)\n");
> +	printf("start performance test (using %s, with cache)\n",
> +	       mp_cache_ops);
>   	if (do_one_mempool_test(mp_cache, cores, 0) < 0)
>   		goto err;
>   
> -	printf("start performance test (with user-owned cache)\n");
> +	if (strcmp(default_pool_ops, mp_cache_ops) != 0) {
> +		printf("start performance test for %s (with cache)\n",
> +		       default_pool_ops);
> +		if (do_one_mempool_test(default_pool_cache, cores, 0) < 0)
> +			goto err;
> +	}
> +
> +	printf("start performance test (using %s, with user-owned cache)\n",
> +	       mp_nocache_ops);
>   	if (do_one_mempool_test(mp_nocache, cores, 1) < 0)
>   		goto err;
>   
> @@ -431,7 +555,8 @@ do_all_mempool_perf_tests(unsigned int cores)
>   err:
>   	rte_mempool_free(mp_cache);
>   	rte_mempool_free(mp_nocache);
> -	rte_mempool_free(default_pool);
> +	rte_mempool_free(default_pool_cache);
> +	rte_mempool_free(default_pool_nocache);
>   	return ret;
>   }
>   

