Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A5ACD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88BF94025F;
	Mon,  1 Jun 2026 10:42:20 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id B364F4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 10:42:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru F3A6366
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780303339;
 bh=t7QkC2NBQ0pUnEP+Oy/rZVrvPAeTnT57z+HbMO40pH8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k4yIWZyJ/H5685Hpw3RrJwGC+6O/WI1vVIn9ZhCpaUF7pY0v0D2sOPmUU+JAPyixB
 DydpSomfJRd6J/OvTmdgyXovP34lGf8mXEJoOHEXqthHBkDIOxaZIExnBs0xXx790V
 fJPYYn5IG1RBIk6Vl0uFnYrMFtOwMJHy5upDrgQg=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id F3A6366;
 Mon,  1 Jun 2026 11:42:18 +0300 (MSK)
Message-ID: <ed5f0c04-ee00-4b4a-b0b8-5abbc53ecdfb@oktetlabs.ru>
Date: Mon, 1 Jun 2026 11:42:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] app/test/mempool_perf: scale down for high core counts
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260529171417.526892-6-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260529171417.526892-6-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/29/26 8:10 PM, Stephen Hemminger wrote:
> On a 32-core system the test matrix runs the cartesian product of
> 4 mempools, 3 core-count configurations and ~340 (n_keep, bulk)
> points at TIME_S=1 second each: about 67 minutes total, well past
> the 10 minute perf-test timeout.
> 
> Two reductions, no loss of meaningful signal:
> 
> 1. Per-point duration: 1 second -> 200 ms.  Each point currently
>     collects 10^5-10^6 mempool ops; 200 ms still yields >10^4
>     samples, well above the noise floor for a cycles-per-op average.
> 
> 2. Matrix trim: drop adjacent bulk and n_keep points that don't
>     produce regime changes.  Retained set covers the boundaries
>     that matter: 1, 4, cache-line burst (8), typical packet burst
>     (32) and cache size (RTE_MEMPOOL_CACHE_MAX_SIZE = 512) for bulk;
>     32 (fits in cache), 512 (= cache size) and 32768 (far exceeds
>     cache) for n_keep.
> 
> Combined effect: ~10x runtime reduction.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

I have no strong opinion on the patch.
In general it LGTM and makes sense.

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

> ---
>   app/test/test_mempool_perf.c | 32 ++++++++++++--------------------
>   1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
> index dd2f0bbaca..6801812a8d 100644
> --- a/app/test/test_mempool_perf.c
> +++ b/app/test/test_mempool_perf.c
> @@ -61,26 +61,21 @@
>    *
>    *    - Pseudorandom max bulk size (*n_max_bulk*)
>    *
> - *      - Max bulk from CACHE_LINE_BURST to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE,
> - *        where CACHE_LINE_BURST is the number of pointers fitting into one CPU cache line.
> + *      - Max bulk: CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE,
> + *        where CACHE_LINE_BURST is the number of pointers fitting into
> + *        one CPU cache line.
>    *
>    *    - Fixed bulk size (*n_get_bulk*, *n_put_bulk*)
>    *
> - *      - Bulk get from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
> - *      - Bulk put from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
> - *      - Bulk get and put from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE, compile time constant
> + *      - Bulk get: 1, 4, CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE
> + *      - Bulk put: 1, 4, CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE
>    *
>    *    - Number of kept objects (*n_keep*)
>    *
> - *      - 32
> - *      - 128
> - *      - 512
> - *      - 2048
> - *      - 8192
> - *      - 32768
> + *      - 32, 512, 32768
>    */
>   
> -#define TIME_S 1
> +#define TIME_MS 200
>   #define MEMPOOL_ELT_SIZE 2048
>   #define MAX_KEEP 32768
>   #define N (128 * MAX_KEEP)
> @@ -257,7 +252,7 @@ per_lcore_mempool_test(void *arg)
>   
>   	start_cycles = rte_get_timer_cycles();
>   
> -	while (time_diff/hz < TIME_S) {
> +	while (time_diff < hz * TIME_MS / 1000) {
>   		if (n_max_bulk != 0)
>   			ret = test_loop_random(mp, cache, n_keep, n_max_bulk);
>   		else if (!use_constant_values)
> @@ -376,13 +371,10 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
>   static int
>   do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cache)
>   {
> -	unsigned int bulk_tab_max[] = { CACHE_LINE_BURST, 32, 64, 128, 256,
> -			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
> -	unsigned int bulk_tab_get[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
> -			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
> -	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
> -			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
> -	unsigned int keep_tab[] = { 32, 128, 512, 2048, 8192, 32768, 0 };
> +	unsigned int bulk_tab_max[] = { CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
> +	unsigned int bulk_tab_get[] = { 1, 4, CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
> +	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
> +	unsigned int keep_tab[] = { 32, 512, 32768, 0 };
>   	unsigned int *max_bulk_ptr;
>   	unsigned int *get_bulk_ptr;
>   	unsigned int *put_bulk_ptr;

