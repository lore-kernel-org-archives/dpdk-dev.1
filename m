Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72052C3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 14:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42EA24067E;
	Mon, 31 Mar 2025 16:48:44 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 5CB594067C
 for <dev@dpdk.org>; Mon, 31 Mar 2025 16:48:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 976B84A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1743432522;
 bh=xD03h5YC+VA1hI/xwtgNm2pEcTSTa/quQvorD+wRYIw=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=TUu98CgUNl17MbziKiYgedJHZrzQTcAD8Xut8SbkR8gKgD/NOSpA1GZ2Ym+l9mh8r
 uuzSdjBsxSk97zPu+wvFSkzHihedrhkkJWFxeXp7f/NpqE6xE93MKVtrRNZhQH7Th5
 sRQn+nSKMwmJDBVjrIu4MhFRal6kApnx7BWiM1NM=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 976B84A;
 Mon, 31 Mar 2025 17:48:42 +0300 (MSK)
Message-ID: <3fd8b3ab-27e9-4972-850f-60466652e223@oktetlabs.ru>
Date: Mon, 31 Mar 2025 17:48:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mempool perf test: test random bulk sizes
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <20250331100343.213430-1-mb@smartsharesystems.com>
 <20250331100343.213430-5-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250331100343.213430-5-mb@smartsharesystems.com>
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

On 3/31/25 13:03, Morten Brørup wrote:
> Bulk requests to get or put objects in a mempool often vary in size.
> A series of tests with pseudo random request sizes, to mitigate the
> benefits of the CPU's dynamic branch predictor, was added.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

[snip]

> @@ -181,9 +240,9 @@ per_lcore_mempool_test(void *arg)
>   	}
>   
>   	/* n_get_bulk and n_put_bulk must be divisors of n_keep */
> -	if (((n_keep / n_get_bulk) * n_get_bulk) != n_keep)
> +	if (!n_max_bulk && (((n_keep / n_get_bulk) * n_get_bulk) != n_keep))

IMHO n_max_bulk == 0 would be easier to read and as far as I remember
DPDK coding style recommends the same style.

>   		GOTO_ERR(ret, out);
> -	if (((n_keep / n_put_bulk) * n_put_bulk) != n_keep)
> +	if (!n_max_bulk && (((n_keep / n_put_bulk) * n_put_bulk) != n_keep))

same

>   		GOTO_ERR(ret, out);
>   	/* for constant n, n_get_bulk and n_put_bulk must be the same */
>   	if (use_constant_values && n_put_bulk != n_get_bulk)
> @@ -200,7 +259,9 @@ per_lcore_mempool_test(void *arg)
>   	start_cycles = rte_get_timer_cycles();
>   
>   	while (time_diff/hz < TIME_S) {
> -		if (!use_constant_values)
> +		if (n_max_bulk)

n_max_bulk != 0
as DPDK coding style says

> +			ret = test_loop_random(mp, cache, n_keep, n_max_bulk);
> +		else if (!use_constant_values)
>   			ret = test_loop(mp, cache, n_keep, n_get_bulk, n_put_bulk);
>   		else if (n_get_bulk == 1)
>   			ret = test_loop(mp, cache, n_keep, 1, 1);
> @@ -261,9 +322,13 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
>   	       use_external_cache ? external_cache_size : (unsigned int) mp->cache_size,
>   	       cores,
>   	       n_keep);
> -	printf("n_get_bulk=%3u n_put_bulk=%3u constant_n=%u ",
> -	       n_get_bulk, n_put_bulk,
> -	       use_constant_values);
> +	if (n_max_bulk)

same

> +		printf("n_max_bulk=%3u ",
> +		       n_max_bulk);
> +	else
> +		printf("n_get_bulk=%3u n_put_bulk=%3u constant_n=%u ",
> +		       n_get_bulk, n_put_bulk,
> +		       use_constant_values);
>   
>   	if (rte_mempool_avail_count(mp) != MEMPOOL_SIZE) {
>   		printf("mempool is not full\n");

[snip]
